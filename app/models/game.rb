class Game < ActiveRecord::Base

  belongs_to :silver_sig_one, class_name: 'Signature'
  belongs_to :silver_sig_two, class_name: 'Signature'
  belongs_to :black_sig_one, class_name: 'Signature'
  belongs_to :black_sig_two, class_name: 'Signature'

  def score
    [silver_score, black_score].join ' - '
  end

  private

  def silver_score
    Score.new(id).silver
  end

  def black_score
    Score.new(id).black
  end

end
