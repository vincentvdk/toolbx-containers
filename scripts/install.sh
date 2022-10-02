#!/bin/sh

gum style --border normal --margin "1" --padding "1" "Choose binary to install"
OPTIONS=$(gum choose --no-limit "terraform" "terraform-ls" "kubectl" "gcloud" "golang" "kubie")

get_binary () {
  ACTION=$(gum choose --no-limit "latest" "version")
  case $ACTION in
    latest)
      asdf install $1
      ;;
    version)
      VERSION=$(gum input --placeholder="Enter version to install")
      asdf install $1 $VERSION
      asdf global $1 $VERSION
      ;;
  esac
}

echo $OPTIONS | tr " " "\n" | while read -r OPT
do
  asdf plugin add $OPT
  get_binary $OPT
done

#ACTION=$(gum choose --cursor.foreground="#f14e32" "")
