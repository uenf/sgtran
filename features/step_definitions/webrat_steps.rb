require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))

# Commonly used webrat steps
# http://github.com/brynary/webrat


#
# ------------------------------------------------------------------------------
#

Dado /^que eu estou na (.+)$/ do |page_name|
  visit path_to(page_name)
end

Quando /^eu vou para "([^\"]*)"$/ do |page_name|
  visit path_to(page_name)
end


Quando /^eu clico em "([^\"]*)"$/ do |link|
  click_link(link)
end

Quando /^eu pressiono "([^\"]*)"$/ do |button|
  click_button(button)
end

Quando /^eu preencho "([^\"]*)" com "([^\"]*)"$/ do |field, value|
  fill_in(field, :with => value)
end

Quando /^eu preencho "([^\"]*)" com a data "([^\"]*)"$/ do |field, value|
  fill_in(field, :with => value)
end

Quando /^eu preencho "([^\"]*)" com a data daqui a "([^\"]*)" dias$/ do |field, value|
  value = (Date.today + value.to_i.days).strftime("%d/%m/%Y")
  fill_in(field, :with => value)
end

Entao /^eu devo estar na (.+)$/ do |page_name|
  URI.parse(current_url).path.should == path_to(page_name)
end

Quando /^eu marco "([^\"]*)"$/ do |field|
  check(field)
end

Quando /^eu não marco "([^\"]*)"$/ do |field|
  uncheck(field)
end

Entao /^eu devo ver "([^\"]*)" selecionado em "([^\"]*)"$/ do |texto, label|
#  field_labeled(label).should be_a_kind_of(Webrat::MultipleSelectField)

  field_labeled(label).element.children.each do |option|
    selected = option.attribute("selected")
    if selected and selected.value == "selected"
      option.children.to_s.should == texto
    end
  end
end

Entao /^eu devo ver o campo "([^\"]*)" preenchido com "([^\"]*)"$/ do |campo, valor|
  field_labeled(campo).value.should =~ /#{valor}/
end

Quando /^eu seleciono "([^\"]*)" em "([^\"]*)"$/ do |value, field|
  select(value, :from => field)
end

Quando /^eu seleciono "([^\"]*)" no campo hora "([^\"]*)"$/ do |time, time_label|
  select_time(time, :from => time_label)
end

Quando /^eu vou para a "(.+)"$/ do |page_name|
  visit path_to(page_name)
end

Entao /^eu devo ver "([^\"]*)"$/ do |text|
  response.should contain(text)
end

Entao /^eu devo ver "([^\"]*)" com a data "([^\"]*)"$/ do |text, text_data|
  response.should contain(text + text_data)
end

Entao /^eu devo ver "([^\"]*)" com a data daqui a "([^\"]*)" dias$/ do |text, value|
  value = (Date.today + value.to_i.days).strftime("%d/%m/%Y")
  response.should contain(text + value)
end

Entao /^eu devo ver "([^\"]*)" em "([^\"]*)"$/ do |text, selector|
  within(selector) do |content|
    if defined?(Spec::Rails::Matchers)
      content.should contain(text)
    else
      hc = Webrat::Matchers::HasContent.new(text)
      assert hc.matches?(content), hc.failure_message
    end
  end
end

Entao /^eu não devo ver "([^\"]*)" em "([^\"]*)"$/ do |text, selector|
  within(selector) do |content|
    if defined?(Spec::Rails::Matchers)
      content.should_not contain(text)
    else
      hc = Webrat::Matchers::HasContent.new(text)
      assert !hc.matches?(content), hc.negative_failure_message
    end
  end
end

#
# ------------------------------------------------------------------------------
#

When /^I go to (.+)$/ do |page_name|
  visit path_to(page_name)
end

When /^I follow "([^\"]*)"$/ do |link|
  click_link(link)
end

When /^I follow "([^\"]*)" within "([^\"]*)"$/ do |link, parent|
  click_link_within(parent, link)
end

When /^I fill in "([^\"]*)" for "([^\"]*)"$/ do |value, field|
  fill_in(field, :with => value)
end

# Use this to fill in an entire form with data from a table. Example:
#
#   When I fill in the following:
#     | Account Number | 5002       |
#     | Expiry date    | 2009-11-01 |
#     | Note           | Nice guy   |
#     | Wants Email?   |            |
#
# TODO: Add support for checkbox, select og option
# based on naming conventions.
#
When /^I fill in the following:$/ do |fields|
  fields.rows_hash.each do |name, value|
    When %{I fill in "#{name}" with "#{value}"}
  end
end

# Use this step in conjunction with Rail's datetime_select helper. For example:
# When I select "December 25, 2008 10:00" as the date and time
When /^I select "([^\"]*)" as the date and time$/ do |time|
  select_datetime(time)
end

# Use this step when using multiple datetime_select helpers on a page or
# you want to specify which datetime to select. Given the following view:
#   <%= f.label :preferred %><br />
#   <%= f.datetime_select :preferred %>
#   <%= f.label :alternative %><br />
#   <%= f.datetime_select :alternative %>
# The following steps would fill out the form:
# When I select "November 23, 2004 11:20" as the "Preferred" date and time
# And I select "November 25, 2004 10:30" as the "Alternative" date and time
When /^I select "([^\"]*)" as the "([^\"]*)" date and time$/ do |datetime, datetime_label|
  select_datetime(datetime, :from => datetime_label)
end

# Use this step in conjunction with Rail's time_select helper. For example:
# When I select "2:20PM" as the time
# Note: Rail's default time helper provides 24-hour time-- not 12 hour time. Webrat
# will convert the 2:20PM to 14:20 and then select it.
When /^I select "([^\"]*)" as the time$/ do |time|
  select_time(time)
end

# Use this step when using multiple time_select helpers on a page or you want to
# specify the name of the time on the form.  For example:
# When I select "7:30AM" as the "Gym" time
When /^I select "([^\"]*)" as the "([^\"]*)" time$/ do |time, time_label|
  select_time(time, :from => time_label)
end

# Use this step in conjunction with Rail's date_select helper.  For example:
# When I select "February 20, 1981" as the date
When /^I select "([^\"]*)" as the date$/ do |date|
  select_date(date)
end

# Use this step when using multiple date_select helpers on one page or
# you want to specify the name of the date on the form. For example:
# When I select "April 26, 1982" as the "Date of Birth" date
When /^I select "([^\"]*)" as the "([^\"]*)" date$/ do |date, date_label|
  select_date(date, :from => date_label)
end

When /^eu marco o radiobutton "([^\"]*)"$/ do |field|
  choose(field)
end

When /^I attach the file at "([^\"]*)" to "([^\"]*)"$/ do |path, field|
  attach_file(field, path)
end

Then /^I should see "([^\"]*)" within "([^\"]*)"$/ do |text, selector|
  within(selector) do |content|
    content.should contain(text)
  end
end

Then /^I should see \/([^\/]*)\/$/ do |regexp|
  regexp = Regexp.new(regexp)
  response.should contain(regexp)
end

Then /^I should see \/([^\/]*)\/ within "([^\"]*)"$/ do |regexp, selector|
  within(selector) do |content|
    regexp = Regexp.new(regexp)
    content.should contain(regexp)
  end
end

Then /^I should not see "([^\"]*)"$/ do |text|
  response.should_not contain(text)
end

Then /^I should not see "([^\"]*)" within "([^\"]*)"$/ do |text, selector|
  within(selector) do |content|
    content.should_not contain(text)
  end
end

Then /^I should not see \/([^\/]*)\/$/ do |regexp|
  regexp = Regexp.new(regexp)
  response.should_not contain(regexp)
end

Then /^I should not see \/([^\/]*)\/ within "([^\"]*)"$/ do |regexp, selector|
  within(selector) do |content|
    regexp = Regexp.new(regexp)
    content.should_not contain(regexp)
  end
end

Then /^the "([^\"]*)" field should contain "([^\"]*)"$/ do |field, value|
  field_labeled(field).value.should =~ /#{value}/
end

Then /^the "([^\"]*)" field should not contain "([^\"]*)"$/ do |field, value|
  field_labeled(field).value.should_not =~ /#{value}/
end

Then /^the "([^\"]*)" checkbox should be checked$/ do |label|
  field_labeled(label).should be_checked
end

Then /^the "([^\"]*)" checkbox should not be checked$/ do |label|
  field_labeled(label).should_not be_checked
end

Then /^I should be on (.+)$/ do |page_name|
  URI.parse(current_url).path.should == path_to(page_name)
end

