package com.telenoetica.android.activity;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.springframework.util.CollectionUtils;

import android.os.Bundle;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.ViewGroup;
import android.widget.Button;

import com.telenoetica.android.rest.AppValuesHolder;
import com.telenoetica.jpa.entities.RoutineVisit;

public class RoutineVisitActivity extends AbstractVisitActivity {
  private Button button1;
  private Button button2;

  @Override
  protected void initializeActivity(final Bundle savedInstanceState) {
    //checkForUserIdandPassword();
    setContentView(R.layout.routine_visit);
    addListenerOnButtonSubmit();
    addListenerOnButtonReset();
  }

  public void addListenerOnButtonSubmit() {
    button1 = (Button) findViewById(R.id.btn_rv_submit);
    final Map<String, Object> valueMap = new LinkedHashMap<String, Object>();
    button1.setOnClickListener(new OnClickListener() {
      @Override
      public void onClick(final View arg0) {
        // Intent intent = new Intent(context, MainMenu.class);
        // startActivity(intent);
        ViewGroup group = (ViewGroup) findViewById(R.id.ll1_rv);
        List<String> errorList = new ArrayList<String>();
        getTargetObject(group, valueMap,errorList);
        if(CollectionUtils.isEmpty(errorList)){
          RoutineVisit routineVisit = new RoutineVisit();
          routineVisit.setUserId(AppValuesHolder.getCurrentUser());
          saveVisit(routineVisit, valueMap);
        }else{
          LOGGER.error("Validation failed");
        }
      }
    });
  }

  private void addListenerOnButtonReset() {
    button2 = (Button) findViewById(R.id.btn_rv_reset);
    button2.setOnClickListener(new OnClickListener() {
      @Override
      public void onClick(final View arg0) {
        Reset r = new Reset();
        ViewGroup group = (ViewGroup) findViewById(R.id.ll1_rv);
        r.clearForm(group);
      }
    });
  }
}
