# require "gakkacho/version"
require "yaml"

module Gakkacho
  BASE_PATH = File.join(File.dirname(__FILE__)) + "/gakkacho"

  universities = Dir[BASE_PATH + "/*.yml"].map do |path|
    YAML.load_file(path)
  end

  universities.each do |university|
    u_path = university["path"]
    u_name = university["name"]

    university["departments"].each do |department|
      d_path = department["path"]
      d_name = department["name"]
      department["courses"].each do |c_path, c_name|
        full_path = "#{BASE_PATH}/#{u_path}/#{d_path}/#{c_path}.yml"
        @@subjects                       ||= {}
        @@subjects[u_name]               ||= {}
        @@subjects[u_name][d_name]       ||= {}
        @@subjects[u_name][d_name][c_name] = YAML.load_file(full_path)
      end
    end
  end

  def all_universities
    @@subjects.map{ |k, v| k }
  end

  def all_departments_in univ
    @@subjects[univ].map{ |k ,v| k }
  end

  def all_courses_in univ, dept
    @@subjects[univ][dept].map{ |k, v| k }
  end

  def all_subjects_in univ, dept, cour, grade, term
    @@subjects[univ][dept][cour][grade.to_i][term]
  end
end
