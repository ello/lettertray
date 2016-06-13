require 'rails_helper'

describe 'receiving and serving up inbound e-mail', type: :request do

  let(:params) do
    { "headers" => "Received: by mx-001.sjc1.sendgrid.net with SMTP id mp6KX8bFC4 Fri, 25 Apr 2014 06:07:40 +0000 (GMT)\nReceived: from mail-pa0-f53.google.com (mail-pa0-f53.google.com [209.85.220.53]) by mx-001.sjc1.sendgrid.net (Postfix) with ESMTPS id 8BA624C1023 for <info@denverstartupweek.org>; Fri, 25 Apr 2014 06:07:40 +0000 (GMT)\nReceived: by mail-pa0-f53.google.com with SMTP id ld10so2734539pab.26 for <info@denverstartupweek.org>; Thu, 24 Apr 2014 23:07:40 -0700 (PDT)\nX-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1e100.net; s=20130820; h=x-gm-message-state:date:from:to:message-id:subject:mime-version :content-type; bh=FIDYCPYWoU2fPr/nK8n88IW5yB2/wvqwj4UPomYI4ds=; b=SX7ioVdNRL4UVxtze89k+876E9IzW3OivChwpbKiFoRozTjXWhHzZ1zEMi6Xa42rwE ZtKq/m3GGE2dpBNUdQUeBSUt84hOwpltUxU+0hbzGvdzFpT680g1YRM8JzIoyzSbYw9I OMbgDA9Hu6AQkcPmYIZ9unPR8ZZie4Ygo/mFpOvCXlDBEED6xkQblqPD0L53qRRUr0i9 L0s9GT3itguZRz8K9xYyn3Vlbga1Aa9z9hbbDT2D6OnLlkYwJ7/K3p96MYENeghRPkRf OPaZLURCKVaPCZha7bmIUqpg7z2giVtbu8QXdOlFh7xqrmLN1CV5WkhyGhpzpasSrOlq ht1g==\nX-Gm-Message-State: ALoCoQkqFic2LbwURkX8hRI08MrBN5EvEYrYlLTszwo7VXKN4BjP/lIZU5fMXoAHrY7Ob7trCjJO\nX-Received: by 10.68.129.169 with SMTP id nx9mr8921604pbb.136.1398406060008; Thu, 24 Apr 2014 23:07:40 -0700 (PDT)\nReceived: from Coreshot.local ([2601:1:8900:faa:a9fa:f3ee:e29e:c205]) by mx.google.com with ESMTPSA id hw8sm13254062pbc.62.2014. 04.24.23.07.38 for <info@denverstartupweek.org> (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128); Thu, 24 Apr 2014 23:07:38 -0700 (PDT)\nDate: Fri, 25 Apr 2014 00:07:37 -0600\nFrom: Jay Zeschin <jay.zeschin@example.com>\nTo: info@denverstartupweek.org\nMessage-ID: <etPan.5359fba9.7545e146.15db4@Coreshot.local>\nSubject: Hello!\nX-Mailer: Airmail Beta (239)\nMIME-Version: 1.0\nContent-Type: multipart/alternative; boundary=\"5359fba9_515f007c_15db4\"\n",
      "dkim"=>"none",
      "to"=>"info@example.com",
      "html"=>"<html><head><style>body{font-family:Helvetica,Arial;font-size:13px}</style></head><body style=\"word-wrap: break-word; -webkit-nbsp-mode: space; -webkit-line-break: after-white-space;\">This is a test...</body></html>",
      "from"=>"Test User <test@example.com>",
      "text"=>"This is a test...",
      "sender_ip"=>"209.85.220.53",
      "spam_report"=>"Spam detection software, running on the system \"mx-001.sjc1.sendgrid.net\", has\nidentified this incoming email as possible spam.  The original message\nhas been attached to this so you can view it (if it isn't spam) or label\nsimilar future email.  If you have any questions, see\nthe administrator of that system for details.\n\nContent preview:  This is a test...\n   [...] \n\nContent analysis details:   (0.0 points, 5.0 required)\n\n pts rule name              description\n---- ---------------------- --------------------------------------------------\n 0.0 HTML_MESSAGE           BODY: HTML included in message\n 0.0 MIME_NO_TEXT           No (properly identified) text body parts\n\n",
      "envelope"=>"{\"to\":[\"info@example.com\"],\"from\":\"test@example.com\"}",
      "attachments"=>"0",
      "subject"=>"Hello!",
      "spam_score"=>"0.002",
      "charsets"=>"{\"to\":\"UTF-8\",\"html\":\"utf-8\",\"subject\":\"UTF-8\",\"from\":\"UTF-8\",\"text\":\"utf-8\"}",
      "SPF"=>"pass" }
  end

  describe 'processing and storing an e-mail' do
    before do
      post '/email_processor', params: params
    end

    it 'responds with a 200' do
      expect(response).to be_success
    end

    it 'stores the e-mail in Redis' do
      expect(Mailbox.new('info@example.com').messages.size).to eq(1)
    end
  end

  describe 'retrieving a stored e-mail' do
    before do
      post '/email_processor', params: params
      get '/messages', params: { email: 'info@example.com' }
    end

    it 'responds with a 200' do
      expect(response).to be_success
    end

    it 'stores the e-mail in Redis' do
      expect(Mailbox.new('info@example.com').messages.size).to eq(1)
    end
  end

end
