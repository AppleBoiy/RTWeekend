#ifndef V1MATERIAL_H
#define V1MATERIAL_H
/*
 * The material class and its derived classes are responsible for determining how rays interact with surfaces.
 * The scatter function is used to determine the behavior of the ray after it hits a surface.
 * The lambertian class represents a diffuse material, while the metal class represents a reflective material.
 *
 * For step 1 to 10.5 Shiny metal
 */


#include "rtweekend.h"
#include "hittable/v1.h"

class hit_record;

class material {
public:
    virtual ~material() = default;

    virtual bool scatter(
            const ray &r_in, const hit_record &rec, color &attenuation, ray &scattered
    ) const {
        return false;
    }
};

class lambertian : public material {
public:
    explicit lambertian(const color &albedo) : albedo(albedo) {}

    bool scatter(const ray &r_in, const hit_record &rec, color &attenuation, ray &scattered)
    const override {
        auto scatter_direction = rec.normal + random_unit_vector();

        // Catch degenerate scatter direction
        if (scatter_direction.near_zero())
            scatter_direction = rec.normal;

        scattered = ray(rec.p, scatter_direction);
        attenuation = albedo;
        return true;
    }

private:
    color albedo;
};


class metal : public material {
public:
    explicit metal(const color &albedo) : albedo(albedo) {}

    bool scatter(const ray &r_in, const hit_record &rec, color &attenuation, ray &scattered)
    const override {
        vec3 reflected = reflect(r_in.direction(), rec.normal);
        scattered = ray(rec.p, reflected);
        attenuation = albedo;
        return true;
    }

private:
    color albedo;
};

#endif // V1MATERIAL_H