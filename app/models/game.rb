class Game < ApplicationRecord
  validates :player_1_name, presence: true
  validates :player_2_name, presence: true

  def self.random_rule
    [
      "Jamie: Jouez avec une main manquante",
      "Cersei: Famille - Faire se toucher deux boules de couleurs opposées entraine une pénalité",
      "Jon: Second souffle - Jouez deux fois de suite",
      "Hodor: Bloqué - Rentrer une boule entraine une pénalité",
      "Tyrion: Ivresse - Vous jouez avec votre mauvaise main",
      "Arya: Camouflage - Vous pouvez toucher les boules adverses en premier sans pénalités",
      "Theon: Couic - Jouez sans queue",
      "White Walker : Undead - chaque boule adverse rentrée revient sur la table dans votre couleur",
      "Sansa : Changement de camp - Touchez une boule adverse en premier",
      "Varys : Manipulation - Intervertissez la place de deux boules"
    ].sample
  end
end
