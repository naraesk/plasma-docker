/*
 * Copyright (C) 2017 by David Baum <david.baum@naraesk.eu>
 *
 * This file is part of plasma-yamaha.
 *
 * plasma-systemd is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * plasma-systemd is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with plasma-codeship.  If not, see <http://www.gnu.org/licenses/>.
 */

#include <QtQml>
#include "process.h"

Process::Process(QObject *parent) : QProcess(parent) {
}

Process::~Process() {
}

bool Process::isActive(const QString &name) {
    QStringList arguments;
    arguments << "systemctl" << "is-active" << name;
    start("sudo", arguments);
    waitForStarted();
    waitForFinished();
    if(readAll() == "active\n") {
        return true;
    } else {
        return false;
    }
}


void Process::start2(const QString &program, const QVariantList &arguments) {
        QStringList args;

        // convert QVariantList from QML to QStringList for QProcess

        for (int i = 0; i < arguments.length(); i++) {
            args << arguments[i].toString();
        }

        start(program, args);
        waitForStarted();
        waitForFinished();}
