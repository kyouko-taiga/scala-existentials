/// An axis-aligned bounding box with a rotation.
public struct OrientedBoundingBox: Hashable {

  /// The vertices of `self` sans rotation.
  let aabb: AxisAlignedBox

  /// The rotation of `self`.
  let rotation: Quaternion

}

extension OrientedBoundingBox {

  public func collisionDistance(from ray: Ray, withCulling cullingIsEnabled: Bool) -> Double? {
    let delta = -ray.origin
    var tmin: Double
    var tmax: Double
    let r = Matrix4(rotation: rotation)

    // Test intersection with the 2 planes perpendicular to the OBB's x-axis.
    do {
      let x = Vector3(x: r[0,0], y: r[1,0], z: r[2,0])
      let ex = x.dot(delta)
      let fx = ray.direction.dot(x)
      if abs(fx) < Double.defaultTolerance {
        // The ray is almost parallel to the near/far planes.
        if (-ex + aabb.minX > 0.0) || (-ex + aabb.maxX < 0.0) { return nil }
      }

      tmin = (ex + aabb.minX) / fx
      tmax = (ex + aabb.maxX) / fx
      if tmin > tmax {
        swap(&tmin, &tmax)
      }
    }

    // Test intersection with the 2 planes perpendicular to the OBB's y-axis.
    do {
      let y = Vector3(x: r[0,1], y: r[1,1], z: r[2,1])
      let ey = y.dot(delta)
      let fy = ray.direction.dot(y)
      if abs(fy) < Double.defaultTolerance {
        // The ray is almost parallel to the near/far planes.
        if (-ey + aabb.minY > 0.0) || (-ey + aabb.maxY < 0.0) { return nil }
      } else {
        var tymin = (ey + aabb.minY) / fy
        var tymax = (ey + aabb.maxY) / fy
        if tymin > tymax {
          swap(&tymin, &tymax)
        }

        if tymin > tmin {
          tmin = tymin
        }
        if tymax < tmax {
          tmax = tymax
        }
        if tmin > tmax {
          return nil
        }
      }
    }

    // Test intersection with the 2 planes perpendicular to the OBB's z-axis.
    do {
      let z = Vector3(x: r[0,2], y: r[1,2], z: r[2,2])
      let ez = z.dot(delta)
      let fz = ray.direction.dot(z)
      if abs(fz) < Double.defaultTolerance {
        // The ray is almost parallel to the near/far planes.
        if (-ez + aabb.minZ > 0.0) || (-ez + aabb.maxZ < 0.0) { return nil }
      } else {
        var tzmin = (ez + aabb.minZ) / fz
        var tzmax = (ez + aabb.maxZ) / fz
        if tzmin > tzmax {
          swap(&tzmin, &tzmax)
        }

        if tzmin > tmin {
          tmin = tzmin
        }
        if tzmax < tmax {
          tmax = tzmax
        }
        if tmin > tmax {
          return nil
        }
      }
    }

    return tmin
  }

}

extension OrientedBoundingBox: CustomStringConvertible {

  public var description: String {
    "OrientedBoundingBox(aabb: \(aabb), rotation: \(rotation))"
  }

}
