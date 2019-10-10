# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
CreateProject.new(
  name: 'TDD测试驱动开发',
  task_string: "建立项目模型\n建立任务模型\n建立模型测试\n编写项目代码\n编写任务代码\n重构项目代码\n重构任务代码\n重构测试代码").create
