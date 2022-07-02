module ApplicationHelper
  def i18n_collection(klass)
    klass.model_name.human count: 2
  end

  def i18n_member(klass)
    klass.model_name.human count: 1
  end

  def i18n_attribute(klass, name)
    klass.human_attribute_name(name)
  end
end
