# frozen_string_literal: true

class Web::Languages::LessonsController < Web::Languages::ApplicationController
  def show
    @lesson = resource_language.lessons.find_by!(slug: params[:id])
    @description = @lesson.version.datum.find_by!(locale: I18n.locale)

    gon.language = resource_language.version
    gon.locale = I18n.locale
    gon.lesson = @lesson.version

    render :show, layout: 'lesson'
  end
end
