class ReportsController < ApplicationController
    before_filter :authenticate_user

    def weeks
        @report_years = []
        @report_weeks = {}
        @report_week_incomes = {}
        @week_totals = {}
        @week_category_totals = {}

        @current_user.incomes.each do |income|
            unless @report_years.include?(income.date.strftime('%Y').to_i)
                @report_years << income.date.strftime('%Y').to_i
            end
        end

        @report_years.sort!

        @report_years.each do |year|
            @report_weeks[year] = []

            @current_user.incomes.each do |income|
                if income.date.strftime('%Y').to_i == year && !@report_weeks[year].include?(income.date.cweek)
                    @report_weeks[year] << income.date.cweek
                end
            end
        end

        @report_weeks.each do |year, weeks|
            weeks.sort!
        end

        @report_weeks.each do |year, weeks|
            unless @report_week_incomes[year]
                @report_week_incomes[year] = {}
            end

            weeks.each do |week|
                unless @report_week_incomes[year][week]
                    @report_week_incomes[year][week] = {}
                end
            end
        end

        @current_user.incomes.each do |income|
            unless @report_week_incomes[income.date.strftime('%Y').to_i][income.date.cweek][income.category]
                @report_week_incomes[income.date.strftime('%Y').to_i][income.date.cweek][income.category] = []
            end

            @report_week_incomes[income.date.strftime('%Y').to_i][income.date.cweek][income.category] << income
        end

        @report_week_incomes.each do |year, weeks|
            unless @week_totals[year]
                @week_totals[year] = {}
            end

            weeks.each do |week, categories|
                unless @week_totals[year][week]
                    @week_totals[year][week] = 0
                end

                categories.each do |category, incomes|
                    incomes.each do |income|
                        @week_totals[year][week] += income.value
                    end
                end
            end
        end

        @biggest_week = 0
        @week_totals.each do |year, weeks|
            weeks.each do |week, total|
                if total > @biggest_week
                    @biggest_week = total
                end
            end
        end

        @week_percent_of_biggest_week = {}

        @week_totals.each do |year, weeks|
            @week_percent_of_biggest_week[year] = {}

            weeks.each do |week, total|
                @week_percent_of_biggest_week[year][week] = total / @biggest_week
            end
        end

        @report_week_incomes.each do |year, weeks|
            @week_category_totals[year] = {}

            weeks.each do |week, categories|
                @week_category_totals[year][week] = {}

                categories.each do |category, incomes|
                    @week_category_totals[year][week][category] = 0

                    incomes.each do |income|
                        @week_category_totals[year][week][category] += income.value
                    end
                end
            end
        end

        @category_percent_of_week_total = {}

        @week_category_totals.each do |year, weeks|
            @category_percent_of_week_total[year] = {}

            weeks.each do |week, categories|
                @category_percent_of_week_total[year][week] = {}
                
                categories.each do |category, total|
                    @category_percent_of_week_total[year][week][category] = total / @week_totals[year][week]
                end
            end
        end

        @report_week_incomes.each do |year, weeks|
            weeks.each do |week, categories|
                @report_week_incomes[year][week] = Hash[ categories.sort_by { |category, incomes| @week_category_totals[year][week][category] }.reverse! ]
            end
        end
    end

    def week
        
    end
end
