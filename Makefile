.PHONY: setup codegen build build-apk build-ios run clean test analyze

setup:
	flutter pub get
	dart run build_runner build --delete-conflicting-outputs

codegen:
	dart run build_runner build --delete-conflicting-outputs

build: build-apk

build-apk:
	flutter pub get
	flutter build apk --release

build-ios:
	flutter pub get
	flutter build ios --release --no-codesign

run:
	flutter run

clean:
	flutter clean
	rm -rf build

test:
	flutter test

analyze:
	flutter analyze
