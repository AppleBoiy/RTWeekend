build:
	./scripts/build.sh

create:
	./scripts/create_ppm.sh

convert:
	./scripts/convert_ppm.sh

deploy: clean build create convert
	./scripts/get_latest_image.sh

latest: clean build
	./scripts/build_latest.sh

clean:
	rm -rf build dist

