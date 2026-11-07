#include <jni.h>
#include <dlfcn.h>
#include <android/log.h>

#define LOG_TAG "MojeGeode"
#define LOGI(...) __android_log_print(ANDROID_LOG_INFO, LOG_TAG, __VA_ARGS__)
#define LOGE(...) __android_log_print(ANDROID_LOG_ERROR, LOG_TAG, __VA_ARGS__)

// Funkcja, która zostanie wywołana automatycznie przy załadowaniu biblioteki do Geometry Dash
void ładowanie_loadera() {
    LOGI("Pomyślnie wstrzyknięto własny loader do Geometry Dash!");

    // 1. Tutaj Twój loader szuka oryginalnej biblioteki GD (libcocos2dcpp.so)
    void* gd_handle = dlopen("libcocos2dcpp.so", RTLD_NOW);
    
    if (!gd_handle) {
        LOGE("Nie można znaleźć plików bazowych Geometry Dash: %s", dlerror());
        return;
    }

    LOGI("Połączono z Geometry Dash. Szukam folderu z modami...");

    // 2. Tutaj Twój loader skanowałby folder w telefonie (np. /sdcard/MojeGeode/mods/)
    // i ładował po kolei pliki z modami użytkowników przy użyciu funkcji dlopen()
}

// Główny punkt wejścia dla systemu Android (JNI)
jint JNI_OnLoad(JavaVM* vm, void* reserved) {
    JNIEnv* env;
    if (vm->GetEnv(reinterpret_cast<void**>(&env), JNI_VERSION_1_6) != JNI_OK) {
        return JNI_ERR;
    }

    // Odpalamy nasz loader w osobnym wątku, żeby nie zawiesić włączania gry
    ładowanie_loadera();

    return JNI_VERSION_1_6;
}
