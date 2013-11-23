require "gakkacho/version"
require "yaml"

module Gakkacho
  YAML.load_file("./lib/universities.yml").each do |univ, univ_dirname|
    university_path = "./lib/universities/#{univ_dirname}"
    YAML.load_file(university_path + "/departments.yml").each do |dept, dept_dirname|
      department_path = university_path+ "/" + dept_dirname
      YAML.load_file(department_path + "/courses.yml").each do |cour, cour_filename|
        @@subjects                 ||= {}
        @@subjects[univ]           ||= {}
        @@subjects[univ][dept]     ||= {}
        @@subjects[univ][dept][cour] = YAML.load_file(department_path + "/#{cour_filename}.yml")
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
