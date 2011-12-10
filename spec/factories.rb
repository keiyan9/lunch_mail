# -*- coding: utf-8 -*-
FactoryGirl.define do
  factory :user do
    password "qqqqqq"
    factory :user_1200_1 do
      email "1200_1@test.com"
    end
    factory :user_1200_2 do
      email "1200_2@test.com"
    end
    factory :user_1230 do
      email "1230@test.com"
    end
    factory :user_1200_off do
      email "1230_off@test.com"
    end
  end
  factory :setting do
    factory :setting_1 do
      area "東京都渋谷区道玄坂1丁目"
      notice_at Time.local(2011,1,1,12,0,0)
      active true
    end
    factory :setting_2 do
      area "東京都豊島区南池袋1丁目"
      notice_at Time.local(2011,1,1,12,0,0)
      active true
    end
    factory :setting_3 do
      area "東京都新宿区新宿3丁目"
      notice_at Time.local(2011,1,1,12,30,0)
      active true
    end
    factory :setting_4 do
      area "東京都渋谷区神宮前1丁目"
      notice_at Time.local(2011,1,1,12,0,0)
      active false
    end
  end
end
