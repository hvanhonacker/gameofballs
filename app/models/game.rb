class Game < ApplicationRecord
  validates :player_1_name, presence: true
  validates :player_2_name, presence: true

  def self.random_rule
    [
      "Jamie: Jouez avec une main manquante",
      "Cersei: Deux boules de la même couleur qui se touchent donnent naissance à une troisième boule",
      "Jon: Second souffle, jouez deux fois de suite",
      "Hodor: Déplacez une de vos boule a côté d'une boule adverse",
      "Tyrion: Ivresse - vous jouez avec votre mauvaise main",
      "Arya: Camouflage - Vous pouvez toucher les boules adverses sans pénalités",
      "Theon: Jouez sans queue",
      "White Walker: une boule rentrée revient dans le jeu dans la couleur opposée",
      "Sansa : Changez la couleur d'une boule de votre adversaire",
      "Varys : Echangez la place de deux boules"
    ].sample
  end
end
