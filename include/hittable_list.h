#ifndef HITTABLE_LIST_H
#define HITTABLE_LIST_H

#include "hittable/v1.h"

#include <vector>

class hittable_list : public v1hittable {
public:
    std::vector<shared_ptr<v1hittable>> objects{};

    hittable_list() = default;

    explicit hittable_list(const shared_ptr<v1hittable> &object) { add(object); }

    void clear() { objects.clear(); }

    void add(const shared_ptr<v1hittable> &object) {
        objects.push_back(object);
    }

    bool hit(const ray &r, double ray_tmin, double ray_tmax, hit_record &rec) const override {
        hit_record temp_rec;
        bool hit_anything = false;
        auto closest_so_far = ray_tmax;

        for (const auto &object: objects) {
            if (object->hit(r, ray_tmin, closest_so_far, temp_rec)) {
                hit_anything = true;
                closest_so_far = temp_rec.t;
                rec = temp_rec;
            }
        }

        return hit_anything;
    }

    bool hit(const ray &r, interval ray_t, hit_record &rec) const override {
        hit_record temp_rec;
        bool hit_anything = false;
        auto closest_so_far = ray_t.max;

        for (const auto &object: objects) {
            if (object->hit(r, interval(ray_t.min, closest_so_far), temp_rec)) {
                hit_anything = true;
                closest_so_far = temp_rec.t;
                rec = temp_rec;
            }
        }

        return hit_anything;
    }
};

#endif