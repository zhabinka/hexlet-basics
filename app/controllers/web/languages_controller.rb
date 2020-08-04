# frozen_string_literal: true

class Web::LanguagesController < Web::ApplicationController
  def show
    @language = Language.find_by!(slug: params[:id])
    @current_module_versions = @language.current_module_versions
                                        .includes(:module)
                                        .order(:order)
                                        .eager_load(:lesson_versions)
                                        .merge(
                                          Language::Lesson::Version.includes(:lesson).order(:order)
                                        )
    @infos_by_module = @language.current_module_infos.with_locale.index_by(&:version_id)
    @infos_by_lesson = @language.current_lesson_infos.with_locale.index_by(&:version_id)

    @finished_lessons_by_id = current_user.finished_lessons_for_language(@language).index_by(&:id)
    @complete_language = current_user.complete_language?(@language)

    @first_lesson = @language.current_lessons.ordered.first
    @next_lesson = current_user.not_finished_lessons_for_language(@language).ordered.first
  end
end
