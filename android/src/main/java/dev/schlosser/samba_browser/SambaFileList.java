package dev.schlosser.samba_browser;

import android.os.Build;

import androidx.annotation.RequiresApi;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.stream.Collectors;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import jcifs.smb.NtlmPasswordAuthentication;
import jcifs.smb.SmbFile;

public class SambaFileList {

    @RequiresApi(api = Build.VERSION_CODES.N)
    static void getShareList(MethodCall call, MethodChannel.Result result) {
        ExecutorService executor = Executors.newSingleThreadExecutor();

//        NtlmPasswordAuthentication auth = null;
//        if (call.hasArgument("domain") && call.hasArgument("username") && call.hasArgument("password"))
//            auth = new NtlmPasswordAuthentication(call.argument("domain"), call.argument("username"), call.argument("password"));

        executor.execute(() -> {
            try {
                String url = call.argument("url");
                assert url != null;
                SmbFile smb = new SmbFile(url, new NtlmPasswordAuthentication(call.argument("domain"), call.argument("username"), call.argument("password")));
                ArrayList shareList = Arrays.stream(smb.listFiles()).map(SmbFile::getPath).collect(Collectors.toCollection(ArrayList::new));
                result.success(shareList);

            } catch (IOException e) {
                e.printStackTrace();
            }
        });
    }
}
