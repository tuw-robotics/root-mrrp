# root-mrrp
Project root for the muli-robot-route-planner


# Install dependencies
```
rosdep update
rosdep install --from-paths ./ws01/src --ignore-src -r -y  # install dependencies for workspace 01
# build a single pkg
colcon build --packages-up-to stage_ros2 --symlink-install --cmake-args -DCMAKE_BUILD_TYPE=Release
```
