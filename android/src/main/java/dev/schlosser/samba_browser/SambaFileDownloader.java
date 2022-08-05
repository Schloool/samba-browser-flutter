package dev.schlosser.samba_browser;

import android.os.Build;

import androidx.annotation.RequiresApi;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import jcifs.smb.NtlmPasswordAuthentication;
import jcifs.smb.SmbFile;
import jcifs.smb.SmbFileInputStream;

public class SambaFileDownloader {

    @RequiresApi(api = Build.VERSION_CODES.N)
    static void saveFile(MethodCall call, MethodChannel.Result result)  {
        ExecutorService executor = Executors.newSingleThreadExecutor();

        String url = call.argument("url");
        if (url.endsWith("/")) {
            result.error("Can not download directory.", null, null);
            return;
        }

        executor.execute(() -> {
            try {
                SmbFile file = new SmbFile(url, new NtlmPasswordAuthentication(call.argument("domain"), call.argument("username"), call.argument("password")));
                SmbFileInputStream in = new SmbFileInputStream(file);

                File outFile = new File(call.argument("saveFolder").toString() + call.argument("fileName").toString());
                FileOutputStream outStream = new FileOutputStream(outFile);

                byte[] fileBytes = new byte[8192];
                int n;
                while(( n = in.read(fileBytes)) != -1) {
                    outStream.write(fileBytes, 0, n);
                }

                outStream.close();
                result.success(outFile.getAbsolutePath());

            } catch (IOException e) {
                e.printStackTrace();
            }
        });
    }

}
