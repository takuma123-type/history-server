class Api::ExportHistoryByIdUsecase < Api::Usecase
  class Input
    attr_accessor :user, :history_id

    def initialize(user:, history_id:)
      @user = user
      @history_id = history_id
    end
  end

  class Output
    attr_accessor :workbook, :errors

    def initialize(workbook: nil, errors: nil)
      @workbook = workbook
      @errors = errors
    end

    def success?
      @errors.nil?
    end
  end

  def export
    history = History.find_by(id: input.history_id, user: input.user)

    if history.nil?
      return Output.new(errors: "History with ID #{input.history_id} not found")
    end

    history_cell = Models::FormattedHistoryCell.new(
      no: history.id,
      period: history.period,
      company_name: history.company_name,
      project_name: history.project_name,
      contents: history.contents,
      others: history.others,
      position: history.position.name,
      scale: "全体: #{history.scale.people}",
      tech_stack: history.core_stack.name,
      infrastructure: history.infrastructure.name
    )

    workbook = generate_excel([history_cell])

    Output.new(workbook: workbook)
  end

  private

  def generate_excel(histories)
    temp_file = Tempfile.new(['history', '.xlsx'], Rails.root.join('tmp'))
    workbook = WriteXLSX.new(temp_file.path)
  
    worksheet = workbook.add_worksheet('経歴')
  
    # ヘッダー
    headers = ['No.', '期間', '企業名', '案件名', '案件概要', 'ポジション', 'プロジェクト規模', '使用言語/FW/ツール', 'サーバ/OS/MW/DB']
    headers.each_with_index do |header, col|
      worksheet.write(0, col, header)
    end
  
    # データ
    histories.each_with_index do |history, row|
      worksheet.write(row + 1, 0, history.no)
      worksheet.write(row + 1, 1, history.period)
      worksheet.write(row + 1, 2, history.company_name)
      worksheet.write(row + 1, 3, history.project_name)
      worksheet.write(row + 1, 4, history.contents)
      worksheet.write(row + 1, 5, history.position)
      worksheet.write(row + 1, 6, history.scale)
      worksheet.write(row + 1, 7, history.tech_stack)
      worksheet.write(row + 1, 8, history.infrastructure)
    end
  
    workbook.close
    temp_file
  end  
end