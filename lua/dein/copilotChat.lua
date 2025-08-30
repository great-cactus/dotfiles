require("CopilotChat").setup {
    debug = false,
    model = 'gpt-5',
    system_prompt = 'Your name is Copilot. You are an AI buddy of the user. You must assist the user not only for coding but also for writing, translating, summerizing the scentence, and proofreading. If you find something missing or wrong in order to assist the user, you must ask the user for more information or clarification. You also must ask the user to provide more information if the user provides an incomplete or unclear request. ',
    prompts = {
        Explain = {
            prompt = "/COPILOT_EXPLAIN 上記のコードを日本語で説明してください",
            mapping = '<leader>cce',
            description = "バディにコードの説明をお願いする。",
        },
        Fix = {
            prompt = "/COPILOT_FIX このコードには問題があります。バグを修正したコードを表示してください。コメントは英語で、説明は日本語でしてください。",
            mapping = '<leader>ccf',
            description = "バディにコードの修正をお願いする。",
        },
        Optimize = {
            prompt = "/COPILOT_REFACTOR モダンでシンプルにすることを目標とし、選択したコードを最適化し、最適化を反映したコードを表示してください。コメントは英語で、説明は日本語でしてください。",
            mapping = '<leader>cco',
            description = "バディにコードの最適化をお願いする。",
        },
        FixDiagnostic = {
            prompt = "コードを診断結果に従って修正し、修正後のコードを表示してください。コメントは英語で、説明は日本語でしてください。",
            mapping = '<leader>ccd',
            description = "バディに静的解析結果に基づいたコードの最適化をお願いする。",
            selection= require('CopilotChat.select').diagnostics,
        },
        Commit = {
            prompt = "変更に対応するコミットメッセージを英語で記述して下さい。タイトルは最大50文字、メッセージは72文字で折り返し、メッセージ全体をgitcommit 言語のコードブロックでラップして下さい。メッセージ作成にあたり、commitizeがあればその規則に従って下さい。",
            mapping = '<leader>ccc',
            description = "バディにコードのコミットをお願いする。",
            selection= require('CopilotChat.select').gitdiff,
        },
        Jap2Eng = {
            prompt = "/USER_JAP2ENG 上記の文章を日本語から英語に翻訳して下さい。もし主語、動詞、目的語などが不明瞭で明確な翻訳ができない場合は、私に追加の質問をし不明瞭な点を解消してから翻訳に取り掛かってください。",
            mapping = '<leader>ccje',
            description = "バディに文章を日本語から英語への翻訳をお願いする。",
            window = {
                layout = 'float',
                width = 0.8,
                height = 0.8,
            },
        },
        Eng2Jap = {
            prompt = "/USER_ENG2JAP 上記の文章を英語から日本語に翻訳して下さい。",
            mapping = '<leader>ccej',
            description = "バディに文章を英語から日本語への翻訳をお願いする。",
            window = {
                layout = 'float',
                width = 0.8,
                height = 0.8,
            },
        },
        EngProofRead = {
            prompt = "/USER_ENGPROOFREAD 上記の文章を文法の誤りを直し、ネイティブから見て自然な英語になるように校閲、推敲して下さい。このとき、並び替えたり別の表現を用いれば不要になる箇所は取り去り、必要十分な文章のみで英文を構成してください。",
            mapping = '<leader>ccep',
            description = "バディに英文校閲をお願いする。",
            window = {
                layout = 'float',
                width = 0.8,
                height = 0.8,
            },
        },
    },
    vim.keymap.set({'n'},
                   '<leader>ccq',
                   function()
                       local input = vim.fn.input("Quick Chat: ")
                       if input ~= "" then
                           require("CopilotChat").ask(input, { selection = require("CopilotChat.select").buffer })
                       end
                   end,
                   { desc = 'Quick Chat'})
}
