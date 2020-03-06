/*
 * Copyright (C) 2020 by David Baum <david.baum@naraesk.eu>
 *
 * This file is part of plasma-docker.
 *
 * plasma-docker is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * plasma-docker is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with plasma-docker.  If not, see <http://www.gnu.org/licenses/>.
 */

#include "process.h"

Process::Process(QObject *parent) : QProcess(parent) {
}

Process::~Process() {
}

void Process::startStack(const QString &file) {
    QStringList arguments;
    arguments << "up" << "-d";
    runDockerCompose(file, arguments);
}

void Process::stopStack(const QString &file) {
    QStringList arguments;
    arguments << "stop";
    runDockerCompose(file, arguments);
}

void Process::startService(const QString &file, const QString &serviceName) {
    QStringList arguments;
    arguments  << "up" << "-d" << serviceName;
    runDockerCompose(file, arguments);
}

void Process::stopService(const QString &file, const QString &serviceName) {
    QStringList arguments;
    arguments << "stop" << serviceName;
    runDockerCompose(file, arguments);
}

QStringList Process::getServices(const QString &file) {
    QStringList arguments;
    arguments << "ps" << "--services";
    runDockerCompose(file, arguments);
    waitForFinished();
    QString composeOutput(readAllStandardOutput());
    return composeOutput.split("\n", QString::SkipEmptyParts);
}

QStringList Process::getRunningServices(const QString &file) {
    QStringList arguments;
    arguments << "ps" << "--services" << "--filter" << "status=running";
    runDockerCompose(file, arguments);
    waitForFinished();
    QString composeOutput(readAllStandardOutput());
    return composeOutput.split("\n", QString::SkipEmptyParts);
}

void Process::runDockerCompose(const QString &file, const QStringList &arguments) {
    QStringList allArguments;
    allArguments << "-f" << file << arguments;
    start("docker-compose", allArguments);
}

void Process::runDocker(const QStringList &arguments) {
    start("docker", arguments);
}

void Process::showLog(const QString &file) {
    QStringList arguments;
    arguments << "--noclose"
              << "-e"
              <<" docker-compose"
              << "-f" << file
              << "logs" << "-f";
    start("konsole", arguments);
}

void Process::runShell(const QString &file, const QString &serviceName) {
    QStringList arguments;
    arguments << "--noclose"
              << "-e"
              << "docker-compose"
              << "-f" << file
              << "exec"
              << serviceName
              << "sh";
    start("konsole", arguments);
}

void Process::startBrowser(const QString &file, const QString &serviceName) {
    QString containerID = getContainerID(file, serviceName);
    QStringList arguments;
    arguments << "port" << containerID;
    runDocker(arguments);
    waitForFinished();
    QString dockerOutput(readAllStandardOutput());
    QStringList ports = dockerOutput.split("\n", QString::SkipEmptyParts);
    for (QString port : ports) {
        const QString f = port.section("->", 1, 1);
        const QUrl url("http://" + f.trimmed());
        KRun::runUrl(url, "text/html", 0, KRun::RunFlags());
    }
}

QString Process::getContainerID(const QString &file, const QString &serviceName) {
    QStringList arguments;
    arguments << "ps" << "-q" << serviceName;
    runDockerCompose(file, arguments);
    waitForFinished();
    QString composeOutput(readAllStandardOutput());
    return composeOutput.trimmed();
}

bool Process::isPublic(const QString &file, const QString serviceName) {
    QStringList arguments;
    arguments << "ps" << serviceName;
    runDockerCompose(file, arguments);
    waitForFinished();
    QString composeOutput(readAllStandardOutput());
    return composeOutput.contains("->");
}