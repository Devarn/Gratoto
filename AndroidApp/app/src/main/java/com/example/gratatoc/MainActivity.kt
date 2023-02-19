package com.example.gratatoc

import android.app.Activity
import android.app.AlertDialog
import android.content.ActivityNotFoundException
import android.content.Intent
import android.graphics.Bitmap
import android.net.Uri
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.provider.MediaStore
import android.provider.Settings
import android.view.LayoutInflater
import android.widget.ImageView
import android.widget.Toast
import androidx.activity.result.contract.ActivityResultContracts
//import coil.decode.EmptyDecoder.result
import coil.load
import coil.transform.CircleCropTransformation
import com.example.gratatoc.databinding.ActivityMainBinding
import com.karumi.dexter.Dexter
import com.karumi.dexter.MultiplePermissionsReport
import com.karumi.dexter.PermissionToken
import com.karumi.dexter.listener.PermissionDeniedResponse
import com.karumi.dexter.listener.PermissionGrantedResponse
import com.karumi.dexter.listener.PermissionRequest
import com.karumi.dexter.listener.multi.MultiplePermissionsListener
import com.karumi.dexter.listener.single.PermissionListener

class MainActivity : AppCompatActivity() {

    private lateinit var binding:ActivityMainBinding
    private val CAMER_REQUEST_CODE=1;
    private val GALlERY_REQUEST_CODE=2
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding=ActivityMainBinding.inflate(layoutInflater)
        setContentView(binding.root)
        binding.btnCamera.setOnClickListener{
            cameraCheckPermission()

        }
        binding.btnGallery.setOnClickListener{
            galleryCheckPermission()

        }
    }
    private fun cameraCheckPermission(){
        Dexter.withContext(this)
            .withPermissions(android.Manifest.permission.READ_EXTERNAL_STORAGE,
                android.Manifest.permission.CAMERA).withListener(

                object :MultiplePermissionsListener{
                    override fun onPermissionsChecked(report: MultiplePermissionsReport?) {
                        report?.let {
                            if(report.areAllPermissionsGranted()){
                            camera()


                        } }


                    }

                    override fun onPermissionRationaleShouldBeShown(
                        p0: MutableList<PermissionRequest>?,
                        p1: PermissionToken?
                    ) {
                        showRotationalDialogForPermission()
                    }

                }
                ).onSameThread().check()

    }
  // private fun camera(){
  //     val intent=Intent(MediaStore.ACTION_IMAGE_CAPTURE)
  //     resultLauncher.launch(intent)
  //
  //  }var resultLauncher=registerForActivityResult(ActivityResultContracts.StartActivityForResult()){
  //          result->
  //      if(result.resultCode== Activity.RESULT_OK){
  //          val data :Intent?=result.data
  //          CAMER_REQUEST_CODE
  //      }
  //}
  private fun camera(){
           val intent=Intent(MediaStore.ACTION_IMAGE_CAPTURE)
          startActivityForResult(intent,CAMER_REQUEST_CODE)}

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        if(resultCode== Activity.RESULT_OK){
            when(requestCode){
                CAMER_REQUEST_CODE->{


                    binding.imageView.setBackgroundResource(android.R.color.transparent)
                    val bitmap= data?.extras?.get("data") as Bitmap
                    binding.imageView.load(bitmap)
                    {
                  crossfade(true)
                    crossfade(1000)

                }


                }
                GALlERY_REQUEST_CODE->{
                    binding.imageView.setBackgroundResource(android.R.color.transparent)
                    binding.imageView.load(data?.data)
                    {
                        crossfade(true)
                        crossfade(1000)

                }
        }
    }}}




//          below methofd was the oroginal for the abover
//var resultLauncher=registerForActivityResult(ActivityResultContracts.StartActivityForResult()){
//    result->
//    if(result.resultCode== Activity.RESULT_OK){
//        when(1 or 2){
//
//            CAMER_REQUEST_CODE->{
//                val bitmap= result.data?.extras?.getString("data") as Bitmap
//                binding.imageView.load(bitmap)                 {
//                    crossfade(true)
//                    crossfade(1000)
//                    transformations(CircleCropTransformation())
//                }
//
//            }
//        }
//    }
//}

    private fun galleryCheckPermission(){
        Dexter.withContext(this).withPermission(
            android.Manifest.permission.READ_EXTERNAL_STORAGE
        ).withListener(object:PermissionListener{
            override fun onPermissionGranted(p0: PermissionGrantedResponse?) {
                 gallery()
            }

            override fun onPermissionDenied(p0: PermissionDeniedResponse?) {
                Toast.makeText(this@MainActivity,
                "Permission has been denied to select image",Toast.LENGTH_SHORT).show()
            showRotationalDialogForPermission()
            }

            override fun onPermissionRationaleShouldBeShown(
                p0: PermissionRequest?,
                p1: PermissionToken?
            ) {
                showRotationalDialogForPermission()
            }


        }).onSameThread().check()

    }
  //  fun gallery(){
  //     val startActivity = registerForActivityResult(ActivityResultContracts.StartActivityForResult()) { result ->
  //         if (result.resultCode == Activity.RESULT_OK) {
  //             val data: Intent? = result.data
  //             GALlERY_REQUEST_CODE
  //         }
  //     }
  //     val intent=Intent(Intent.ACTION_PICK)
  //     intent.type="image/*"
  //     startActivity.launch(intent)

    //}


    //
    //  }var resultLauncher=registerForActivityResult(ActivityResultContracts.StartActivityForResult()){
    //          result->
    //      if(result.resultCode== Activity.RESULT_OK){
    //          val data :Intent?=result.data
    //          CAMER_REQUEST_CODE
    //      }

    fun gallery(){
        val intent=Intent(Intent.ACTION_PICK)
        intent.type="image/*"
        startActivityForResult(intent,GALlERY_REQUEST_CODE)

    }
    private fun showRotationalDialogForPermission(){
        AlertDialog.Builder(this)
            .setMessage("Required permission have not been granted successfully"
            +"Please enable it under app settings")

             .setPositiveButton("Go to settings"){_,_->
                try {
                    val intent=Intent(Settings.ACTION_APPLICATION_DETAILS_SETTINGS)
                    val uri= Uri.fromParts("package",packageName,null)
                    intent.data=uri
                    startActivity(intent)



                }catch (e:ActivityNotFoundException){
                    e.printStackTrace()
                }




            }
            .setNegativeButton("Cancel"){dialog, _->
                dialog.dismiss()
            }.show()
    }

}

