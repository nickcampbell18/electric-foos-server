class GameCreator

  def call(silver_team: , black_team: , timestamp:)
    silver_team.each do |signature|
      sig = Signature.find_or_create_by sig: signature
      unless sig.player
    end
    black_team.each do |signature|
      Signature.find_or_create_by sig: signature
    end
  end

end
