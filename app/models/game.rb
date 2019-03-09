class Game < ApplicationRecord
  validates :player_1_name, presence: true
  validates :player_2_name, presence: true

  def self.random_rule
    [
      "Jamie: Handicap, Jouez avec main poing fermé (si possible)",
      "Cersei: Reproduction, Faites toucher deux boules de la même couleur",
      "Jon Snow: Second souffle, jouez deux fois de suite",
      "Hodor: Télé-Protection, déplacez une de vos boule a côté d'une boule adverse",
      "Tyrion: Ivresse, vous jouez avec votre mauvaise main",
      "Arya: Camouflage: Vous pouvez toucher/rentrer les boules adverses sans pénalités",
      "Theon: Jouez sans queue",
      "White Walker: une boule rentrée = une boule de couleur opposée ressucitée"
      "Sansa : Changez de camps !"
    ].sample
  end
end
