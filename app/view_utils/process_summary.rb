module ProcessSummary

  Summary = EntityUtils.define_builder(
    [:preauthorize_available, :boolean, default: false],
    [:request_available, :boolean, default: false]
  )

  def summarize(processes)
    summary = processes.reduce({}) { |info, process|
      info[:preauthorize_available] = true if process[:process] == :preauthorize
      info[:request_available] = true if process[:author_is_seller] == false
      info
    }

    Summary.call(summary)
  end
end
