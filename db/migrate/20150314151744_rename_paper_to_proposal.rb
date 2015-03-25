class RenamePaperToProposal < ActiveRecord::Migration
  def change
    rename_table 'papers', 'proposals'

    # Rails automatically renames indices and this results in a name
    # that is too long for Postgresql, so I change it manually first
    rename_index 'ratings', 'index_ratings_on_user_paper_rating_id_and_rating_dimension_id', 'i_ratings_on_user_paper_rating_id_and_rating_dimension_id'
    rename_table 'user_paper_ratings', 'user_proposal_ratings'

    rename_column 'notes', 'paper_id', 'proposal_id'
    rename_column 'ratings', 'user_paper_rating_id', 'user_proposal_rating_id'
    rename_column 'user_proposal_ratings', 'paper_id', 'proposal_id'
  end
end
