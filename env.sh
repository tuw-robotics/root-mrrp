# skript to source a ros2 project
if [ ! -f $PWD/.env.local ]; then
    PROJECT_NAME=$(basename "$PWD")
    echo "A 'env.local' did not exist and will be created."
    echo "export ROS_DISTRO=jazzy                        # defines your ROS distro" > .env.local  
    echo "export PROJECT_NAME=$PROJECT_NAME               # defines your project name" >> .env.local
    echo 'export PROJECT_DIR=${PROJECTS_DIR}/${PROJECT_NAME}   # defines your project root' >> .env.local
    echo "export DOCKER_OWNER=tuwrobotics                 # used to name docker owner" >> .env.local 
    echo "export DOCKER_PREFIX=tr                         # used to name docker images" >> .env.local 
    echo "export USER_ID=$(id -u)                   # user id" >> .env.local 
    echo "export GROUP_ID=$(id -g)                  # group id" >> .env.local 
    echo "export ROS_DOMAIN_ID=0                          # Can be used to avoid interference"  >> .env.local
    echo "export ROS_AUTOMATIC_DISCOVERY_RANGE=LOCALHOST  # nodes will only try to discover other nodes on the same machine "  >> .env.local
fi
source $PWD/.env.local

if [ -f /.dockerenv ]; then
    echo -e "Welcome to the project \e[43;34m'$PROJECT_NAME'\e[0m"
    # Perform your Docker-specific actions here
else
    echo -e "\e[31mYou are not inside a docker container!\e[0m"
    return 0  # Exit with a status code 0 (success)
fi

if [ ! -f /opt/ros/$ROS_DISTRO/setup.bash ]; then
    echo "ROS_DISTRO '$ROS_DISTRO' not installed!"
    return 0  # Exit with a status code 0 (success)
fi

source_ws () {
    if [ -f "$1" ]; then
        source $1
        echo "sourced $1"
    else 
        echo "$1 does not exist."
    fi
}

echo "** ROS2 $ROS_DISTRO initialized with $RMW_IMPLEMENTATION **"
source /opt/ros/$ROS_DISTRO/setup.bash
source_ws ${PROJECT_DIR}/ws00/install/setup.bash
source_ws ${PROJECT_DIR}/ws01/install/setup.bash
source_ws ${PROJECT_DIR}/ws02/install/setup.bash
