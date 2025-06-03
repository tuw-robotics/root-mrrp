
ws01/src/tuw_geometry:
	git clone -b ros2 git@github.com:tuw-robotics/tuw_geometry.git $@

ws01/src/tuw_msgs:
	git clone -b ros2 git@github.com:tuw-robotics/tuw_msgs.git $@
	
ws01/src/tuw_robotics:
	git clone -b ros2-devel git@github.com:tuw-robotics/tuw_robotics.git $@
	
ws00/src/Stage:
	git clone -b ros2 git@github.com:tuw-robotics/Stage.git $@

ws00/src/stage_ros2:
	git clone -b jazzy git@github.com:tuw-robotics/stage_ros2.git $@
	
clone: \
	ws00/src/stage_ros2 \
	ws00/src/Stage \
	ws01/src/tuw_geometry \
	ws01/src/tuw_robotics \
	ws01/src/tuw_msgs
