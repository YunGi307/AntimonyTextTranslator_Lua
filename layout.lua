import "android.webkit.WebView"


layout = {
 LinearLayout;
 layout_width="fill";
 orientation="vertical";
 layout_height="fill";
 {
  EditText;
  layout_width="fill";
  layout_marginRight="8dp";
  id="contentBox";
  layout_marginBottom="8dp";
  layout_marginTop="15dp";
  layout_height="260dp";
  layout_marginLeft="8dp";
  layout_gravity="228dp";
  hint="在此输入内容";
 };
 {
  LinearLayout;
  layout_width="fill";
  {
   Button;
   layout_weight="2";
   layout_marginRight="5dp";
   layout_marginLeft="10dp";
   text="导出";
   onClick="expertFile";
   id="expert";
  };
  {
   Button;
   layout_weight="2";
   layout_marginRight="10dp";
   layout_marginLeft="5dp";
   text="转换";
   onClick="convertText";
   id="convert";
  };
 };
 {
  WebView;
  layout_marginLeft="14dp";
  layout_marginBottom="13dp";
  id="result";
  layout_marginTop="13dp";
  layout_marginRight="14dp";
 };
};


function showMsg(content)
 -- 该函数来源: 与 andlua 相关的群
 local MsgLayout = {
  LinearLayout;
  id="toastb";
  orientation="vertical";
  {
   TextView;
   background="#FF3C8BDA";
   padding="8dp";
   textSize="15sp";
   TextColor="#ffffffff";
   layout_width="100%w";
   layout_height="40dp";
   gravity="center";
   text="提示出错";
   id="text";
  };

 };
 local toast = Toast.makeText(activity,"内容",Toast.LENGTH_SHORT).setView(loadlayout(MsgLayout))
 toast.setGravity(Gravity.BOTTOM,0, 0)
 text.Text = tostring(content)
 toast.show()
end



