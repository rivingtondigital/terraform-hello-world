# task.tf

data "template_file" "task_def_templ"{
  template  = file("${path.module}/templates/ha_docker_ecs_app.json.tpl")
  vars      = {
    container_name  = var.project_name
    app_image       = var.app_image
    container_port  = element(var.container_ports, 0)
    internal_port   = element(var.host_ports, 0)
    aws_region      = var.region
  }
}

resource "aws_ecs_task_definition" "app" {
  family                    = "rdig-app-task"
  execution_role_arn        = aws_iam_role.ecs_task_role.arn
  network_mode              = "bridge"
  requires_compatibilities  = ["EC2"]

  container_definitions     = data.template_file.task_def_templ.rendered
}

resource "aws_ecs_service" "main_service" {
  name                = "cb-service"
  cluster             = aws_ecs_cluster.main.arn
  task_definition     = aws_ecs_task_definition.app.arn
  launch_type         = "EC2"
  scheduling_strategy = "DAEMON"
  
  depends_on = [aws_iam_role_policy_attachment.ecs_agent]
}


