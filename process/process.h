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

#ifndef PROCESS_H
#define PROCESS_H

#include <QProcess>
#include <QVariant>
#include <QString>

class Process : public QProcess
{
    Q_OBJECT
public:
    Process( QObject *parent = 0);
    ~Process();

public Q_SLOTS:
    bool isActive(const QString &name);
    void start2(const QString &program, const QVariantList &arguments);
    //Q_INVOKABLE QByteArray readAll();
};

#endif // PROCESS_H
