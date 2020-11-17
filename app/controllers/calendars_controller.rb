class CalendarsController < ApplicationController

  # １週間のカレンダーと予定が表示されるページ
  def index
    get_week
    @plan = Plan.new
  end

  # 予定の保存
  def create
    Plan.create(plan_params)
    redirect_to action: :index
  end

  private

  def plan_params
    params.require(:plan).permit(:date, :plan)
  end

  def get_week
    wdays = ['(日)','(月)','(火)','(水)','(木)','(金)','(土)']

    # Dateオブジェクトは、日付を保持しています。下記のように`.today.day`とすると、今日の日付を取得できます。
    @get_date = Date.today
    # 例)　今日が2月1日の場合・・・ Date.today.day => 1日

    @week_days = []

    plans = Plan.where(date: @get_date..@get_date + 6)

    7.times do |x|
      today_plans = []
      plan = plans.map do |plan|
        today_plans.push(plan.plan) if plan.date == @get_date + x
      end
      wday_num = Date.today.wday + x#Date.today.wdayを利用して添字となる数値を得る
      #もしもwday_numが7以上であれば、7を引く
      if wday_num <= 8#条件式を記述
        wday_num = wday_num - 7
      end
      days = { month: (@get_date + x).month, date: (@get_date+x).day, plans: today_plans, wday: wdays[wday_num]}
      @week_days.push(days)
    end

  end
end
