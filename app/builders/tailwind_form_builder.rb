class TailwindFormBuilder < ActionView::Helpers::FormBuilder
  def text_field(attribute, options = {}, &block)
    if options[:leading_icon]
      default_opts = { class: "#{classes_for(attribute, options)} pl-10" }

      text_layout(attribute) { leading_icon(&block) + super(attribute, options.merge(default_opts)) }
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
    default_opts = { class: "#{@template.yass(label: :base)} #{options[:class]}" }

    super(attribute, text, options.merge(default_opts), &)
  end

  def check_box(attribute, options = {}, checked_value = '1', unchecked_value = '0')
    default_opts = { class: "#{options[:class]} h-4 w-4 border-gray-300 rounded" }

    super(attribute, options.merge(default_opts), checked_value, unchecked_value)
  end

  private

  def classes_for(attribute, options)
    state = @object.errors[attribute].present? ? :invalid : :valid

    [@template.yass(text_field: state), options[:class]].compact.join(' ')
  end

  def text_layout(attribute)
    @template.content_tag :div, class: 'mt-2 relative rounded-md shadow-sm' do
      yield + attribute_error_icon(attribute)
    end
  end

  def attribute_error_icon(attribute)
    return if @object.errors[attribute].blank?

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
    state = @object.errors[attribute].present? ? :visible : :hidden

    @template.content_tag :div, class: @template.yass(error_field: state) do
      @object.errors[attribute].first
    end
  end
end
