# encoding: utf-8
module Holidays
  # This file is generated by the Ruby Holidays gem.
  #
  # Definitions loaded: definitions/at.yaml
  #
  # To use the definitions in this file, load it right after you load the
  # Holiday gem:
  #
  #   require 'holidays'
  #   require 'generated_definitions/at'
  #
  # All the definitions are available at https://github.com/alexdunae/holidays
  module AT # :nodoc:
    def self.defined_regions
      [:at]
    end

    def self.holidays_by_month
      {
              0 => [{:function => lambda { |year| Holidays.easter(year)+1 }, :function_id => "easter(year)+1", :name => "Ostermontag", :regions => [:at]},
            {:function => lambda { |year| Holidays.easter(year)+39 }, :function_id => "easter(year)+39", :name => "Christi Himmelfahrt", :regions => [:at]},
            {:function => lambda { |year| Holidays.easter(year)+50 }, :function_id => "easter(year)+50", :name => "Pfingstmontag", :regions => [:at]},
            {:function => lambda { |year| Holidays.easter(year)+60 }, :function_id => "easter(year)+60", :name => "Fronleichnam", :regions => [:at]}],
      1 => [{:mday => 1, :name => "Neujahrstag", :regions => [:at]},
            {:mday => 6, :name => "Heilige Drei Könige", :regions => [:at]}],
      5 => [{:mday => 1, :name => "Staatsfeiertag", :regions => [:at]}],
      8 => [{:mday => 15, :name => "Mariä Himmelfahrt", :regions => [:at]}],
      10 => [{:mday => 26, :name => "Nationalfeiertag", :regions => [:at]}],
      11 => [{:mday => 1, :name => "Allerheiligen", :regions => [:at]}],
      12 => [{:mday => 8, :name => "Mariä Empfägnis", :regions => [:at]},
            {:mday => 25, :name => "1. Weihnachtstag", :regions => [:at]},
            {:mday => 26, :name => "2. Weihnachtstag", :regions => [:at]}]
      }
    end
  end


end

Holidays.merge_defs(Holidays::AT.defined_regions, Holidays::AT.holidays_by_month)
