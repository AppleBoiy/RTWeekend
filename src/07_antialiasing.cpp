#include "rtweekend.h"
#include "hittable_list.h"
#include "sphere/v1.h"
#include "cameras/v1.h"


int main() {
    hittable_list world;

    world.add(make_shared<v1sphere>(point3(0, 0, -1), 0.5));
    world.add(make_shared<v1sphere>(point3(0, -100.5, -1), 100));

    v1camera cam;

    cam.aspect_ratio = 16.0 / 9.0;
    cam.image_width = 400;
    cam.samples_per_pixel = 100;

    cam.render(world);
}