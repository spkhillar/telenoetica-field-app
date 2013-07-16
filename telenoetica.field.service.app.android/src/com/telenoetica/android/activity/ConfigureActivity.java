package com.telenoetica.android.activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

import com.telenoetica.android.rest.AppValuesHolder;
public class ConfigureActivity extends ApplicationBaseActivity {
  private Button btnSubmit;

  private EditText hostConfiguredIpAddressEditText;
  @Override
  protected void initializeActivity(final Bundle savedInstanceState) {
    //checkForUserIdandPassword();
    setContentView(R.layout.configure);
    addBtnSubmitAction();
  }
  private void addBtnSubmitAction() {
    btnSubmit = (Button) findViewById(R.id.btn_config_submit);
    hostConfiguredIpAddressEditText = (EditText) findViewById(R.id.et_config_address);
    btnSubmit.setOnClickListener(new OnClickListener() {
      @Override
      public void onClick(final View arg0) {
        final String hostConfiguredIpAddress = hostConfiguredIpAddressEditText.getText().toString();
        if(hostConfiguredIpAddress != null && !AppValuesHolder.getHost().equals(hostConfiguredIpAddress)){
          AppValuesHolder.setHost(hostConfiguredIpAddress);
        }
        Toast.makeText(context, "Configuration updated. Login to continue.", Toast.LENGTH_SHORT).show();
        Intent intent = new Intent(context, LoginActivity.class);
        startActivity(intent);
      }
    });
  }
}