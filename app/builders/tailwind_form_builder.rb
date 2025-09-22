class TailwindFormBuilder < ActionView::Helpers::FormBuilder
  # rubocop:disable Layout/LineLength
  TEXT_FIELD_CLASSES = ClassVariants.build(
    base: 'block w-full border rounded-md py-2 px-3 focus:outline-hidden dark:bg-gray-700/50 dark:border-gray-500 dark:text-gray-300 dark:placeholder-gray-400 dark:focus:ring-2 dark:focus:border-transparent',
    variants: {
      state: {
        valid: 'border-gray-300 focus:ring-blue-600 focus:border-blue-600 dark:focus:ring-blue-400',
        invalid: 'pr-10 border-red-300 text-red-900 placeholder-red-300 focus:ring-red-500 focus:border-red-500'
      }
    }
  )

  LABEL_CLASSES = ClassVariants.build(
    base: 'block text-sm font-medium text-gray-700 dark:text-gray-200'
  )

  SELECT_CLASSES = ClassVariants.build(
    base: 'block w-full mt-6 sm:mt-0 border rounded-md py-2 px-3 focus:outline-hidden dark:bg-gray-700/50 dark:border-gray-500 dark:text-gray-300 dark:placeholder-gray-400 dark:focus:ring-2 dark:focus:border-transparent border-gray-300 focus:ring-blue-600 focus:border-blue-600 dark:focus:ring-blue-400'
  )

  ERROR_FIELD_CLASSES = ClassVariants.build(
    base: 'mt-2 text-sm text-red-600 dark:text-red-500',
    variants: {
      state: {
        visible: '',
        hidden: 'hidden'
      }
    }
  )
  # rubocop:enable Layout/LineLength

  def text_field(attribute, options = {}, &)
    if options[:leading_icon]
      default_opts = { class: "#{classes_for(attribute, options)} pl-10" }

      text_layout(attribute) { leading_icon(&) + super(attribute, options.merge(default_opts)) }
    else
      default_opts = { class: classes_for(attribute, options) }

      text_layout(attribute) { super(attribute, options.merge(default_opts)) }
    end + attribute_error_message(attribute)
  end

  def email_field(attribute, options = {})
    default_opts = { class: classes_for(attribute, options) }

    text_layout(attribute) { super(attribute, options.merge(default_opts)) } + attribute_error_message(attribute)
  end

  def date_field(attribute, options = {})
    default_opts = { class: classes_for(attribute, options) }

    text_layout(attribute) { super(attribute, options.merge(default_opts)) } + attribute_error_message(attribute)
  end

  def password_field(attribute, options = {})
    default_opts = { class: classes_for(attribute, options) }

    text_layout(attribute) { super(attribute, options.merge(default_opts)) } + attribute_error_message(attribute)
  end

  def text_area(attribute, options = {})
    default_opts = { class: "mt-1 #{classes_for(attribute, options)}" }

    text_layout(attribute) { super(attribute, options.merge(default_opts)) } + attribute_error_message(attribute)
  end

  def label(attribute, text = nil, options = {}, &)
    default_opts = { class: LABEL_CLASSES.render(class: options[:class]) }

    super(attribute, text, options.merge(default_opts), &)
  end

  def check_box(attribute, options = {}, checked_value = '1', unchecked_value = '0')
    default_opts = { class: "#{options[:class]} h-4 w-4 border-gray-300 rounded-sm" }

    super(attribute, options.merge(default_opts), checked_value, unchecked_value)
  end

  def select(attribute, choices, options = {}, html_options = {})
    default_opts = { class: SELECT_CLASSES.render(class: html_options[:class]) }

    super(attribute, choices, options, html_options.merge(default_opts))
  end

  private

  def classes_for(attribute, options)
    state = @object && @object.errors[attribute].present? ? :invalid : :valid

    TEXT_FIELD_CLASSES.render(state: state, class: options[:class])
  end

  def text_layout(attribute)
    @template.content_tag :div, class: 'mt-2 relative rounded-md shadow-xs' do
      yield + attribute_error_icon(attribute)
    end
  end

  def attribute_error_icon(attribute)
    return if @object.blank? || @object.errors[attribute].blank?

    @template.content_tag :div, class: 'absolute inset-y-0 right-0 pr-3 flex items-center pointer-events-none' do
      @template.inline_svg_tag(
        'icons/exclaimation-circle.svg',
        class: 'h-5 w-5 text-red-500',
        aria: true,
        title: 'Error',
        desc: 'Error icon'
      )
    end
  end

  def leading_icon(&)
    @template.content_tag(:div, class: 'pointer-events-none absolute inset-y-0 left-0 flex items-center pl-3', &)
  end

  def attribute_error_message(attribute)
    return if @object.blank?

    state = @object.errors[attribute].present? ? :visible : :hidden

    @template.content_tag :div, class: ERROR_FIELD_CLASSES.render(state: state) do
      @object.errors[attribute].first
    end
  end
end
