# frozen_string_literal: true

require 'yaml'
require_relative './version'

module Checklist
  # Class to build the selection menu
  class Menu
    def initialize
      dir = File.dirname(__FILE__)
      @yaml = YAML.safe_load(File.read("#{dir}/check-list.yml"))
      @list_counter = 0
      @res = []
      show_checklist_types
    end

    def show_checklist_types
      yaml_keys = @yaml.keys
      puts "Checklist version #{Checklist::Version.version}\n\n"
      puts "Please select checklist:\n"
      yaml_keys.each_with_index do |key, index|
        puts "#{index + 1}. #{key}"
      end
      get_input('list_selector', nil)
    end

    # rubocop:disable Metrics/MethodLength
    def get_input(type, line)
      value = gets.chomp
      case type
      when 'list_selector'
        value = list_validator(value)
        case value
        when 1
          @type = 'CodeReview'
          show_checklist
        when 2
          @type = 'Development'
          show_checklist
        when 3
          @type = 'DeploymentToProduction'
          show_checklist
        end
      when 'y_n'
        y_n_validator(value, line)
        show_checklist
      end
    end
    # rubocop:enable Metrics/MethodLength

    # rubocop:disable Metrics/MethodLength
    def show_checklist
      checklist = @yaml[@type]
      system 'clear'
      if @list_counter < checklist.length
        line = checklist[@list_counter]['point']
        puts "#{line} y/n/na"
        if checklist[@list_counter]['sub']
          sub = checklist[@list_counter]['sub']
          sub.each_with_index do |_sub_line, index|
            puts "\t#{checklist[@list_counter]['sub'][index]}"
          end
        end
        get_input('y_n', line)
      else
        show_report
      end
    end
    # rubocop:enable Metrics/MethodLength

    def show_report
      puts "*#{@type} checklist*"
      puts ''
      @res.each do |line|
        puts "* #{line}"
      end
    end

    def list_validator(value)
      value.to_i
    end

    # rubocop:disable Metrics/MethodLength
    def y_n_validator(value, line)
      case value
      when 'y'
        add_positive(line)
        @list_counter += 1
      when 'n'
        add_negative(line)
        @list_counter += 1
      when 'na'
        add_na(line)
        @list_counter += 1
      when 'q'
        system 'clear'
        puts 'Good Bye'
        exit
      end
    end
    # rubocop:enable Metrics/MethodLength

    def add_positive(line)
      @res.push("#{line} (/) _#{Time.now}_")
    end

    def add_negative(line)
      @res.push("#{line} (x) _#{Time.now}_")
    end

    def add_na(line)
      @res.push("#{line} (*b) _#{Time.now}_")
    end
  end
end
