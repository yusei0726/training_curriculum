class CalendarsController < ApplicationController

  # １週間のカレンダーと予定が表示されるページ
  def index
    getWeek
    @plan = Plan.new
  end

  # 予定の保存
  def create
    Plan.create(plan_params)
    redirect_to action: :index
  end

  private

  def plan_params
    params.require(:calendars).permit(:date, :plan)
  end

  def get_week
    wdays = ['(日)','(月)','(火)','(水)','(木)','(金)','(土)']

    # Dateオブジェクトは、日付を保持しています。下記のように`.today.day`とすると、今日の日付を取得できます。
    @get.day = Date.today
    # 例)　今日が2月1日の場合・・・ Date.today.day => 1日

    @get_week = []

    plans = Plan.where(date: @get_day..@get_day + 6)

    7.times do |x|
      today_plans = []
      plan = plans.map do |plan|
        today_plans.push(plan.plan) if plan.date == @get_date + x
      end
      days = {month: (@get_date + x).month, date: (@get_date+x).day, plans: today_plans}
      @get_week.push(days)
    end

  end
end
