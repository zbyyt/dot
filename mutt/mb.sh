#!/bin/sh

case $1 in

    a|aa|all)
        echo "mailboxes $(\
            find "$2" \
                -maxdepth 1 -mindepth 1 -type d \
                -printf "+'%f' ")"
        ;;
    nn)
        echo "mailboxes $(\
            find "$2" \
                -maxdepth 1 -mindepth 1 -type d \
                -name "x.*" \
                -printf "+'%f' ")"
        ;;
    tt)
        echo "mailboxes $(\
            find "$2" \
                -maxdepth 1 -mindepth 1 -type d \
                ! -name "x.*" \
                -printf "+'%f' ")"
        ;;
esac

