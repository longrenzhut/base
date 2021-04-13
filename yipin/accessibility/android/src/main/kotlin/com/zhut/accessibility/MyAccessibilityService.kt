package com.zhut.accessibility

import android.accessibilityservice.AccessibilityService
import android.accessibilityservice.AccessibilityServiceInfo
import android.annotation.TargetApi
import android.content.Context
import android.content.Intent
import android.os.Build
import android.os.Handler
import android.os.HandlerThread
import android.provider.Settings
import android.view.accessibility.AccessibilityEvent
import android.view.accessibility.AccessibilityNodeInfo
import android.widget.Toast

class MyAccessibilityService: AccessibilityService() {



    companion object{
        var mService: MyAccessibilityService? = null

        var isFirst = true
        var picCount = 4

        /**
         * 辅助功能是否启动
         */
        fun isStart(): Boolean {
            return mService != null
        }


        fun startService(ctx: Context,count: Int,callback:(suc: Boolean)->Unit){
            if(!isStart()){
                var isSuc = true
                try {
                    val intent = Intent(Settings.ACTION_ACCESSIBILITY_SETTINGS)
                    ctx.startActivity(intent)
                } catch (e: Exception) {
                    isSuc = false
                    ctx.startActivity(Intent(Settings.ACTION_SETTINGS));
                    e.printStackTrace()
                }
            }
            else{
                isFirst = true
                picCount = count
                callback.invoke(true)
            }
        }

        fun stopSelf(){
            mService?.stopSelf()
        }

    }

    /**
     * 当启动服务的时候就会被调用
     */
    override fun onServiceConnected() {
        super.onServiceConnected()
        mService = this
    }

    var isFind = false
    var enterFriend = false
    var goDialog = false
    var isEnterPic = false
    var isSelectedSuc = false
    /**
     * 监听窗口变化的回调
     */
    override fun onAccessibilityEvent(event: AccessibilityEvent?) {

        val type = event?.eventType
        when(type){
            //根据通知栏事件回调类型进行处理
            AccessibilityEvent.TYPE_NOTIFICATION_STATE_CHANGED -> {
//                Toast.makeText(baseContext,"11111",Toast.LENGTH_LONG).show()
            }
            AccessibilityEvent.TYPE_VIEW_SELECTED -> {
                Toast.makeText(baseContext,"2222",Toast.LENGTH_LONG).show()
            }
            AccessibilityEvent.TYPE_VIEW_CLICKED -> {
                if(isFind) {
                    enterFriend = clickById("com.tencent.mm:id/h8z",1000)
                    isFind = false
                }
                //弹出框选择 图片
                if(goDialog) {
                    //进入选择图片界面
                    isEnterPic =  clickById("com.tencent.mm:id/h8v",400,1)
                    goDialog = false
                }

//                选择图片点击完成按钮
                if(isSelectedSuc){
                    val clickSuc =  clickById("com.tencent.mm:id/d6",1000)
                    isSelectedSuc = false
                    if(clickSuc){
//                        stopSelf()
                    }
                }
            }
            //当窗口的状态发生改变时
            AccessibilityEvent.TYPE_WINDOW_STATE_CHANGED -> {
                if(isFirst) {
                    isFind = clickFind("com.tencent.mm:id/dtf")
                    if(isFind)
                        isFirst = false
                }

                if(enterFriend) {
                    //进入朋友圈弹出选择图片框
                    goDialog = clickById("com.tencent.mm:id/d8", 1000)
                    enterFriend = false
                }

                if(isEnterPic){
                    //选择图片
                    Handler().postDelayed({
                        isSelectedSuc = clickSelectedPic("com.tencent.mm:id/fbe")
                    },1000)


                    isEnterPic = false
                }

            }
        }
    }



    /**
     * 中断服务的回调
     */
    override fun onInterrupt() {
        mService = null
    }

    override fun onDestroy() {
        mService = null
        super.onDestroy()
    }


    /**
     * 通过ID获取控件，并进行模拟点击
     * @param clickId
     */
    @TargetApi(Build.VERSION_CODES.JELLY_BEAN_MR2)
    private fun clickFind(clickId: String):Boolean {
        val nodeInfo  = rootInActiveWindow
        if (nodeInfo != null) {
            val list: List<AccessibilityNodeInfo> = nodeInfo.findAccessibilityNodeInfosByViewId(clickId)
            if(!list.isNullOrEmpty() && list.size == 4){
                val parent = list[2].parent
                parent?.let{
                    Handler().postDelayed({
                        it.performAction(AccessibilityNodeInfo.ACTION_CLICK)
                    },400)
                }
                return true
            }
        }
        return false
    }


    @TargetApi(Build.VERSION_CODES.JELLY_BEAN_MR2)
    private fun clickSelectedPic(clickId: String):Boolean {
        val nodeInfo  = rootInActiveWindow
        if (nodeInfo != null) {
            val list: List<AccessibilityNodeInfo> = nodeInfo.findAccessibilityNodeInfosByViewId(clickId)
            if(!list.isNullOrEmpty()&& list.size > picCount){
                for(index in 0 until picCount){
                    val item = list[index]
                    if(index == picCount - 1){
                        Handler().postDelayed({
                            item.performAction(AccessibilityNodeInfo.ACTION_CLICK)
                        },400)
                    }
                    else {
                        item.performAction(AccessibilityNodeInfo.ACTION_CLICK)
                    }
                }
                return true
            }
        }
        return false
    }

    @TargetApi(Build.VERSION_CODES.JELLY_BEAN_MR2)
    private fun clickById(clickId: String,delayMillis: Long = 400,index: Int = 0):Boolean {
        val nodeInfo  = rootInActiveWindow
        if (nodeInfo != null) {
            val list: List<AccessibilityNodeInfo> = nodeInfo.findAccessibilityNodeInfosByViewId(clickId)
            if(!list.isNullOrEmpty()&& list.size > index){
                val item = list[index]
                Handler().postDelayed({
                    item.performAction(AccessibilityNodeInfo.ACTION_CLICK)
                },delayMillis)
                return true
            }
        }
        return false
    }

    @TargetApi(Build.VERSION_CODES.JELLY_BEAN_MR2)
    private fun clickByText(text: String) {
        val nodeInfo  = rootInActiveWindow
        if (nodeInfo != null) {
            val list: List<AccessibilityNodeInfo> = nodeInfo.findAccessibilityNodeInfosByText(text)
            for (item in list) {
                item.performAction(AccessibilityNodeInfo.ACTION_CLICK)
            }
        }
    }


    fun settingAccessibilityInfo() {
        val packageNames = arrayOf("com.tencent.mm")
        val mAccessibilityServiceInfo =  AccessibilityServiceInfo()
        // 响应事件的类型，这里是全部的响应事件（长按，单击，滑动等）
        mAccessibilityServiceInfo.eventTypes = AccessibilityEvent.TYPES_ALL_MASK;
        // 反馈给用户的类型，这里是语音提示
        mAccessibilityServiceInfo.feedbackType = AccessibilityServiceInfo.FEEDBACK_SPOKEN;
        // 过滤的包名
        mAccessibilityServiceInfo.packageNames = packageNames
        serviceInfo = mAccessibilityServiceInfo;
    }
}

//disableSelf()：禁用当前服务，也就是在服务可以通过该方法停止运行
//findFoucs(int falg)：查找拥有特定焦点类型的控件
//getRootInActiveWindow()：如果配置能够获取窗口内容,则会返回当前活动窗口的根结点
//getSeviceInfo()：获取当前服务的配置信息
//onAccessibilityEvent(AccessibilityEvent event)：有关AccessibilityEvent事件的回调函数，系统通过sendAccessibiliyEvent()不断的发送AccessibilityEvent到此处
//performGlobalAction(int action)：执行全局操作，比如返回，回到主页，打开最近等操作
//setServiceInfo(AccessibilityServiceInfo info)：设置当前服务的配置信息
//getSystemService(String name)：获取系统服务
//onKeyEvent(KeyEvent event)：如果允许服务监听按键操作，该方法是按键事件的回调，需要注意，这个过程发生了系统处理按键事件之前
//onServiceConnected()：系统成功绑定该服务时被触发，也就是当你在设置中开启相应的服务，系统成功的绑定了该服务时会触发，通常我们可以在这里做一些初始化操作
//onInterrupt()：服务中断时的回调