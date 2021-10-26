#!/bin/bash
#flutterShell="$(which flutter)"
#flutterDir="$(cd `dirname $flutterShell` && cd .. && pwd)"
#export PATH=$PATH:$flutterDir/.pub-cache/bin
#export PATH=$PATH:$HOME/.pub-cache/bin

#flutter pub global activate --source assets_generator

# agen:
#-h, --[no-]help
#-p, --path          Flutter
#                    ( ".")
#-f, --folder        assets
#                    ( "assets")
#-w, --[no-]watch     assets
#                    ( )
#-t, --type          pubsepec.yaml
#                    "d"  "- assets/images/"
#                    "f"    "- assets/images/xxx.jpg"
#                    ( "d")
#-s, --[no-]save
#                     "agen" ，
#-o, --out           const
#                    ( "lib" )
#-r, --rule          consts
#                    "lwu"() : "assets_images_xxx_jpg"
#                    "uwu"() : "ASSETS_IMAGES_XXX_JPG"
#                    "lcc"()      : "assetsImagesXxxJpg"
#                    ( "lwu")
#-c, --class         const
#                    ( "Assets")
#    --const-ignore  const(const)

# pubspec.yamlassets
flutter pub run assets_generator  -t d --no-save -r lwu -f assets/ -o lib/generated/