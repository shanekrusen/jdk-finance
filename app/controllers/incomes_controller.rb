class IncomesController < ApplicationController
    def index
        @months = ["December", "November", "October", "September", "August", "July", "June", "May", "April", "March", "February", "January"]
        @incomes = Income.all
        @monthyears = { }
        @incomeyears = { }

        @incomes.each do |income|
            @income_year = income.date.strftime("%Y")
            @income_year_sym = income.date.strftime("%Y").to_sym
            @income_month = income.date.strftime("%B")
            @income_month_sym = income.date.strftime("%B").to_sym
            @income_month_year = income.date.strftime("%B %Y")
            @income_month_year_sym = income.date.strftime("%B %Y")
            @income_day = income.date.day.to_s
            @income_day_sym = income.date.day.to_s.to_sym
            
            if !@monthyears[@income_year_sym]
                @monthyears[@income_year_sym] = []
            end

            if !@monthyears[@income_year_sym].include?(@income_month)
                @monthyears[@income_year_sym] << @income_month
            end
        
            if !@incomeyears[@income_month_year_sym]
                @incomeyears[@income_month_year_sym] = Hash.new
            end

            if !@incomeyears[@income_month_year_sym][@income_day_sym]
                @incomeyears[@income_month_year_sym][@income_day_sym] = []
            end

            if !@incomeyears[@income_month_year_sym][@income_day_sym].include?(income)
                @incomeyears[@income_month_year_sym][@income_day_sym] << income
            end
        end

        @monthyears.each do |key, months|
            months.sort_by!{|month| [@months.index(month)]}
        end

        @monthyears = Hash[ @monthyears.sort_by { |key, val| key.to_s }.reverse! ]

        @incomeyears.each do |monthyear, days|
            days.each do |day, incomes|
                incomes.sort_by!{|income| income.date.day }
            end
        end

        @incomeyears = Hash[ @incomeyears.sort_by { |key, val| Date.strptime(key, "%B %Y")}.reverse! ]
        @incomeyears_map = @incomeyears.dup

        @incomeyears.each do |monthyear, days|
            @incomeyears[monthyear] = Hash[ @incomeyears[monthyear].sort_by { |key, val| key.to_s }.reverse! ]
        end
    end

    def new
    
    end
end
