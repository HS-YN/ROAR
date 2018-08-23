Xephyr :1 -extension MIT-SHM -extension XTEST &
sudo nvidia-docker run --rm -it -e DISPLAY=:1 -v /tmp/.X11-unix/X1:/tmp/.X11-unix/X1:rw -p 8895:8895 hs-yn/roar:latest bash
