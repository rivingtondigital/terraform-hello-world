[
  {
    "name": "${container_name}",
    "image": "${app_image}",
    "networkMode": "bridge",
		"memoryReservation": 256,
    "logConfiguration": {
        "logDriver": "awslogs",
        "options": {
          "awslogs-group": "/ecs/fg_ssh",
          "awslogs-region": "${aws_region}",
          "awslogs-stream-prefix": "ecs"
        }
    },
    "portMappings": [
      {
        "containerPort": ${container_port},
        "hostPort": ${internal_port}
      }
    ]
  }
]

