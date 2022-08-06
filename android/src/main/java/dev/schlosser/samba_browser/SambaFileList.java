package dev.schlosser.samba_browser;

import android.os.Build;

import androidx.annotation.RequiresApi;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Objects;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.stream.Collectors;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import jcifs.smb.NtlmPasswordAuthentication;
import jcifs.smb.SmbAuthException;
import jcifs.smb.SmbException;
import jcifs.smb.SmbFile;

public class SambaFileList {

    @RequiresApi(api = Build.VERSION_CODES.N)
    static void getShareList(MethodCall call, MethodChannel.Result result) {
        ExecutorService executor = Executors.newSingleThreadExecutor();

        String url = call.argument("url");
        if (!url.endsWith("/")) {
            result.error("Can only show list content of folders.", null, null);
            return;
        }

        executor.execute(() -> {
            try {
                SmbFile folder = new SmbFile(url, new NtlmPasswordAuthentication(call.argument("domain"), call.argument("username"), call.argument("password")));
                ArrayList shareList = Arrays.stream(folder.listFiles())
                        .filter(Objects::nonNull)
                        .map(SmbFile::getPath)
                        .collect(Collectors.toCollection(ArrayList::new));
                result.success(shareList);

            } catch(SmbAuthException e) {
                result.error("The given user could not be authenticated.", e.getMessage(), null);
            } catch (IOException | NullPointerException e) {
                result.error("A " + e.getClass() + " occurred.", e.getMessage(), null);
            }
        });
    }
}
