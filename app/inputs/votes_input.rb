# This VotesInput is meant to be used with SimpleForm
# We're using this so we can vote for a specific paper

# note: this is stupid and simple form is stupid
# note2: please fix this

class VotesInput < SimpleForm::Inputs::CollectionRadioButtonsInput
  def input
    collection.map do |n, smiley_class|
      @builder.label "#{attribute_name}_#{n}" do
        button = @builder.radio_button attribute_name, n
        smiley = '<i class="fa %s"></i>' % smiley_class
        [button, smiley].join(' ').html_safe
      end
    end.join.html_safe
  end

  def input_type
    :radio_buttons
  end

  def collection
    [[0, 'fa-frown-o'], [1, 'fa-meh-o'], [2, 'fa-smile-o']]
  end

  def label
    ''
  end
end
