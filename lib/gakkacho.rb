require "gakkacho/version"
require "yaml"

module Gakkacho
  BASE_PATH = File.join(File.dirname(__FILE__)) + "/gakkacho"

  universities = []
  universities << "tokyo_university_of_science"

  universities.each do |university|
    university_yaml = YAML.load_file("#{BASE_PATH}/#{university}.yml")
    university_name = university_yaml["name"]
    university_yaml["departments"].each do |department|
      department_path = department["path"]
      department_name = department["name"]
      department["courses"].each do |course_path, course_name|
        course_yaml = YAML.load_file("#{BASE_PATH}/#{university}/#{department_path}/#{course_path}.yml")
        @@subjects ||= {}
        @@subjects[university_name] ||= {}
        @@subjects[university_name][department_name] ||= {}
        @@subjects[university_name][department_name][course_name] = course_yaml
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
